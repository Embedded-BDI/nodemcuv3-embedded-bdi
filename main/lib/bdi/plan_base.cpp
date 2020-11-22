/*
 * plan_base.cpp
 *
 *  Created on: May 25, 2020
 *      Author: Matuzalem Muller
 */

#include "plan_base.h"

PlanBase::PlanBase(std::uint8_t size)
{
  _size = size;
  _plan_base.init(size);
}

bool PlanBase::add_plan(Plan plan)
{
  if (this->is_full())
  {
    return false;
  }

  _plan_base.push_back(plan);
  return true;
}

Plan * PlanBase::revise(Event * event, BeliefBase * belief_base)
{
  if (event)
  {
    if ((event->get_operator() == EventOperator::BELIEF_ADDITION)     ||
        (event->get_operator() == EventOperator::BELIEF_DELETION)     ||
        (event->get_operator() == EventOperator::GOAL_ADDITION)       ||
        (event->get_operator() == EventOperator::GOAL_DELETION)       ||
        (event->get_operator() == EventOperator::TEST_GOAL_ADDITION)  ||
        (event->get_operator() == EventOperator::TEST_GOAL_DELETION))
    {
      for (std::uint8_t i = 0; i < _plan_base.size(); i++)
      {
        if (event->get_operator() == _plan_base.item_at(i)->get_operator())
        {
          if (event->get_statement().is_equal(_plan_base.item_at(i)->get_statement()))
          {
            if (_plan_base.item_at(i)->get_context()->is_valid(belief_base))
            {
              return _plan_base.item_at(i);
            }
          }
        }
      }
    }
  }
  return nullptr;
}

bool PlanBase::is_full()
{
  return (_plan_base.size() == _size);
}
